<template>
    <admin-layout>
        <template #header>
            <h4 class="page-heading">
                {{ __('Home Page Settings') }}
            </h4>
        </template>
        <div>
            <div class="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <home-page-settings-form :settings="homePageSettings"></home-page-settings-form>
                <arc-section-border />
                <top-bar-settings-form :settings="topBarSettings"></top-bar-settings-form>
                <arc-section-border />
                <hero-settings-form :settings="heroSettings"></hero-settings-form>
                <arc-section-border />
                <feature-settings-form :settings="featureSettings"></feature-settings-form>
                <arc-section-border />
                <category-settings-form :settings="categorySettings"></category-settings-form>
                <arc-section-border />
                <stat-settings-form :settings="statSettings"></stat-settings-form>
                <arc-section-border />
                <testimonial-settings-form :settings="testimonialSettings"></testimonial-settings-form>
                <arc-section-border />
                <cta-settings-form :settings="ctaSettings"></cta-settings-form>
                <arc-section-border />
                <footer-settings-form :settings="footerSettings"></footer-settings-form>
            </div>
        </div>
    </admin-layout>
</template>

<script>
    import AdminLayout from '@/Layouts/AdminLayout'
    import ArcSectionBorder from "@/Components/SectionBorder";
    import HomePageSettingsForm from "@/Pages/Admin/Settings/HomePageSettingsForm";
    import TopBarSettingsForm from "@/Pages/Admin/Settings/TopBarSettingsForm";
    import FeatureSettingsForm from "@/Pages/Admin/Settings/FeatureSettingsForm";
    import CtaSettingsForm from "@/Pages/Admin/Settings/CtaSettingsForm";
    import HeroSettingsForm from "@/Pages/Admin/Settings/HeroSettingsForm";
    import TestimonialSettingsForm from "@/Pages/Admin/Settings/TestimonialSettingsForm";
    import StatSettingsForm from "@/Pages/Admin/Settings/StatSettingsForm";
    import CategorySettingsForm from "@/Pages/Admin/Settings/CategorySettingsForm";
    import FooterSettingsForm from "@/Pages/Admin/Settings/FooterSettingsForm";

    export default {
        components: {
            AdminLayout,
            ArcSectionBorder,
            HomePageSettingsForm,
            TopBarSettingsForm,
            FeatureSettingsForm,
            CtaSettingsForm,
            HeroSettingsForm,
            TestimonialSettingsForm,
            StatSettingsForm,
            CategorySettingsForm,
            FooterSettingsForm
        },
        props: {
            homePageSettings: Object,
            heroSettings: Object,
            topBarSettings: Object,
            featureSettings: Object,
            ctaSettings: Object,
            testimonialSettings: Object,
            statSettings: Object,
            categorySettings: Object,
            footerSettings: Object
        },
        metaInfo() {
            return {
                title: this.title
            }
        },

        computed: {
            title() {
                return this.__('Home Page Settings')+' - ' + this.$page.props.general.app_name;
            }
        },
    }
</script>
